/// E.g.
///
/// @my_special_comment -> typ="my_special_comment", data=""
/// @my_special_comment my comment -> typ="my_special_comment", data="my comment"
/// @my_special_comment my comment1 my comment2 -> typ="my_special_comment", data="my comment1 my comment2"
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
pub fn parse_comments(comments: Vec<String>) -> Comment {
    let mut i_comments = Vec::with_capacity(comments.len());

    for comment in comments {
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
        } else {
            i_comments.push(InnerComment::Normal { data: comment });
        }
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
        ];
        let parsed = parse_comments(comments);
        assert_eq!(parsed.comments.len(), 4);
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
    }
}
