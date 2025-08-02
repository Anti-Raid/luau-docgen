mod type_gen;

use std::io::Read;

use full_moon::visitors::Visitor;

fn main() {
    eprintln!("luau-docgen rust extension started");

    // Parse command line arguments skipping the first one
    // which is the program name
    let args = std::env::args().skip(1).collect::<Vec<_>>();

    if args.len() != 2 {
        eprintln!(
            "Usage: {} <path to luau file> <whether or not to include nonexported types>",
            args[0]
        );
        std::process::exit(1);
    }

    let contents = {
        if args[0].starts_with("file://") {
            let path = &args[0][7..];
            std::fs::read_to_string(path).expect("Failed to read file")
        } else if args[0] == "-" {
            // Read from stdin
            let mut input = String::new();
            std::io::stdin()
                .read_to_string(&mut input)
                .expect("Failed to read from stdin");

            input
        } else {
            args[0].clone()
        }
    };

    let include_nonexported_types = args[1].parse::<bool>().unwrap_or(false);

    let result = full_moon::parse_fallible(&contents, full_moon::LuaVersion::luau());
    if !result.errors().is_empty() {
        let mut error = "ParseScriptFileError\n".to_string();
        for err in result.errors() {
            error.push_str(&format!("{}\n", err));
        }
        eprintln!("{}", error);
        std::process::exit(1);
    }

    let mut type_visitor = crate::type_gen::TypeBlockVisitor {
        include_nonexported_types,
        ..Default::default()
    };

    let ast = result.into_ast();

    type_visitor.visit_ast(&ast);

    #[derive(serde::Serialize)]
    struct TypeSet {
        types: Vec<crate::type_gen::Type>,
    }

    #[derive(serde::Serialize)]
    struct Result {
        unsupported_count: usize,
        typeset: TypeSet,
    }

    let typeset = serde_json::to_string(&Result {
        typeset: TypeSet {
            types: type_visitor.found_types,
        },
        unsupported_count: type_visitor.unsupported_count,
    })
    .expect("Failed to serialize typeset");

    print!("{}", typeset);
}
