/// E.g.
///
/// @my_special_comment -> typ="my_special_comment", data=""
/// @my_special_comment my comment -> typ="my_special_comment", data="my comment"
/// @my_special_comment my comment1 my comment2 -> typ="my_special_comment", data="my comment1 my comment2"
///
/// A block style comment can be made using the following syntax:
///
/// # [comment_type]
/// line 1 \
/// line 2 \
/// end line
///
/// The block comment ends at the line which does not end with a backslash
///
/// # warning
/// This is a warning comment \
/// with two lines
///
/// # note
/// This is a single line note comment
#[derive(PartialEq, Eq, Debug, Clone, serde::Serialize, serde::Deserialize)]
#[serde(tag = "comment_type")]
pub enum InnerComment {
    Normal { data: String },
    Special { typ: String, data: String },
}

/// Contains a parsed list of comments
#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct Comment {
    pub comments: Vec<InnerComment>,
}

/// Parses a list of comments into a Comment structure
pub fn parse_comments(comments: Vec<String>, ignore_nondoc: bool) -> Comment {
    let mut i_comments = Vec::with_capacity(comments.len());

    let mut i = 0;
    loop {
        let comment = if i < comments.len() {
            &comments[i]
        } else {
            break;
        };

        if ignore_nondoc && !comment.starts_with('-') {
            i += 1;
            continue;
        }

        let comment = comment.trim_start_matches("-").trim().to_string();

        // Single line comment
        if comment.starts_with('@') {
            let parts: Vec<&str> = comment.splitn(2, ' ').collect();
            if parts.len() == 1 {
                i_comments.push(InnerComment::Special {
                    typ: parts[0][1..].to_string(),
                    data: String::new(),
                });
            } else {
                i_comments.push(InnerComment::Special {
                    typ: parts[0][1..].to_string(),
                    data: parts[1].to_string(),
                });
            }
        }
        // Multiline block comment
        else if comment.starts_with("#") {
            let Some(comment) = comment.strip_prefix('#') else {
                i += 1;
                continue;
            };
            let block_comment = comment.trim().to_string();
            let mut data_set = Vec::new();
            i += 1; // Go to the next line
            loop {
                if i >= comments.len() {
                    break;
                }

                let next_comment = &comments[i];

                if ignore_nondoc && !next_comment.starts_with('-') {
                    i += 1;
                    continue;
                }

                data_set.push(
                    next_comment
                        .trim_start_matches('-')
                        .trim_end_matches("\\")
                        .to_string(),
                );

                if !next_comment.ends_with('\\') {
                    break;
                }

                i += 1;
            }

            let data = data_set.join("\n");
            i_comments.push(InnerComment::Special {
                typ: block_comment,
                data,
            });
        }
        // Normal comment
        else {
            i_comments.push(InnerComment::Normal { data: comment });
        }

        i += 1;
    }

    Comment {
        comments: i_comments,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_comments_basic() {
        let comments = vec![
            "@my_special_comment".to_string(),
            "@my_special_comment my comment".to_string(),
            "@my_special_comment my comment1 my comment2".to_string(),
            "normal comment".to_string(),
            "# my_special_comment".to_string(),
            "This is a block comment \\".to_string(),
            "with two lines".to_string(),
            "and a normal comment again!".to_string(),
            "# warning".to_string(),
            "Too awesome!".to_string(),
            "Too cool!".to_string(),
            "# error".to_string(),
            "Beep boop!".to_string(),
        ];
        let parsed = parse_comments(comments, false);
        assert_eq!(parsed.comments.len(), 9);
        assert_eq!(
            parsed.comments[0],
            InnerComment::Special {
                typ: "my_special_comment".to_string(),
                data: "".to_string(),
            }
        );
        assert_eq!(
            parsed.comments[1],
            InnerComment::Special {
                typ: "my_special_comment".to_string(),
                data: "my comment".to_string(),
            }
        );
        assert_eq!(
            parsed.comments[2],
            InnerComment::Special {
                typ: "my_special_comment".to_string(),
                data: "my comment1 my comment2".to_string(),
            }
        );
        assert_eq!(
            parsed.comments[3],
            InnerComment::Normal {
                data: "normal comment".to_string(),
            }
        );

        assert_eq!(
            parsed.comments[4],
            InnerComment::Special {
                typ: "my_special_comment".to_string(),
                data: "This is a block comment \nwith two lines".to_string(),
            }
        );

        assert_eq!(
            parsed.comments[5],
            InnerComment::Normal {
                data: "and a normal comment again!".to_string(),
            }
        );

        assert_eq!(
            parsed.comments[6],
            InnerComment::Special {
                typ: "warning".to_string(),
                data: "Too awesome!".to_string(),
            }
        );

        assert_eq!(
            parsed.comments[7],
            InnerComment::Normal {
                data: "Too cool!".to_string(),
            }
        );

        assert_eq!(
            parsed.comments[8],
            InnerComment::Special {
                typ: "error".to_string(),
                data: "Beep boop!".to_string(),
            }
        );
    }
}
