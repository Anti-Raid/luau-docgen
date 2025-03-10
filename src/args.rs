#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct ParsedArg {
    pub name: String,
    pub values: Vec<String>,
    pub short: bool,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct ParsedArgs {
    pub args: Vec<ParsedArg>,
}

impl ParsedArgs {
    /// Upsert an argument into the list of arguments
    fn upsert(&mut self, arg: ParsedArg) {
        for pot_arg in self.args.iter_mut() {
            if pot_arg.name == arg.name {
                pot_arg.values.extend(arg.values);
                return;
            }
        }

        self.args.push(arg);
    }
}

/// Parses a list of arguments into a ParsedArgs structure
///
/// Note that repeated arguments are upserted into the same argument without duplication
pub fn parse_args<T: AsRef<str>>(args: Vec<T>) -> ParsedArgs {
    let mut parsed_args = ParsedArgs { args: Vec::new() };

    let mut i = 0;
    loop {
        if i >= args.len() {
            break;
        }

        let arg = args[i].as_ref();

        // Try for long argument first
        if let Some(arg_name) = arg.strip_prefix("--") {
            // Try to get the next argument as value if not special
            let values = if i + 1 < args.len() && !args[i + 1].as_ref().starts_with('-') {
                i += 1;
                args[i]
                    .as_ref()
                    .split('=')
                    .map(|x| x.to_string())
                    .collect::<Vec<_>>()
            } else {
                Vec::with_capacity(0)
            };

            parsed_args.upsert(ParsedArg {
                name: arg_name.to_string(),
                values,
                short: false,
            });
        } else if let Some(arg_name) = arg.strip_prefix("-") {
            // Try to get the next argument as value if not special
            let values = if i + 1 < args.len() && !args[i + 1].as_ref().starts_with('-') {
                i += 1;
                args[i]
                    .as_ref()
                    .split('=')
                    .map(|x| x.to_string())
                    .collect::<Vec<_>>()
            } else {
                Vec::with_capacity(0)
            };

            parsed_args.upsert(ParsedArg {
                name: arg_name.to_string(),
                values,
                short: true,
            });
        }

        i += 1;
    }

    parsed_args
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_args() {
        let args = vec![
            "--include-nonexported-types",
            "-e",
            "true",
            "--documentor",
            "documentor.luau",
            "-d",
            "true",
            "-e",
            "false",
        ];

        let parsed_args = parse_args(args);

        assert_eq!(parsed_args.args.len(), 4);

        assert_eq!(parsed_args.args[0].name, "include-nonexported-types");
        assert_eq!(parsed_args.args[0].values, Vec::<String>::new());
        assert!(!parsed_args.args[0].short);

        assert_eq!(parsed_args.args[1].name, "e");
        assert_eq!(
            parsed_args.args[1].values,
            vec!["true".to_string(), "false".to_string()]
        );
        assert!(parsed_args.args[1].short);

        assert_eq!(parsed_args.args[2].name, "documentor");
        assert_eq!(
            parsed_args.args[2].values,
            vec!["documentor.luau".to_string()]
        );
        assert!(!parsed_args.args[2].short);

        assert_eq!(parsed_args.args[3].name, "d");
        assert_eq!(parsed_args.args[3].values, vec!["true".to_string()]);
        assert!(parsed_args.args[3].short);
    }
}
