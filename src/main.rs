//#![feature(non_exhaustive_omitted_patterns_lint)]
//#![deny(non_exhaustive_omitted_patterns)]

mod token_ref_extractor;
mod type_gen;
use full_moon::{parse_fallible, visitors::Visitor};
use std::path::PathBuf;
use type_gen::TypeBlockVisitor;

#[derive(Debug, clap::Parser)]
struct CliArgs {
    #[arg(name = "path")]
    /// The path to the script to run
    script: PathBuf,
}

fn main() {
    let args = <CliArgs as clap::Parser>::parse();

    if !args.script.exists() {
        eprintln!("Error: Script file does not exist: {:?}", args.script);
        std::process::exit(1);
    }

    let source = std::fs::read_to_string(&args.script).unwrap_or_else(|_| {
        eprintln!("Error: Failed to read script file: {:?}", args.script);
        std::process::exit(1);
    });

    let mut type_visitor = TypeBlockVisitor {
        found_types: Vec::new(),
    };

    let result = parse_fallible(&source, full_moon::LuaVersion::luau());
    if !result.errors().is_empty() {
        eprintln!("Error: Failed to parse script file: {:?}", args.script);
        for error in result.errors() {
            eprintln!("Error: {:?}", error);
        }
        std::process::exit(1);
    }

    let ast = result.into_ast();

    type_visitor.visit_ast(&ast);

    println!("{:#?}", type_visitor.found_types);
}
