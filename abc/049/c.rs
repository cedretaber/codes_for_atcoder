macro_rules! get {
    ($t:ty) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.trim().parse::<$t>().unwrap()
        }
    };
    ($($t:ty),*) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            let mut iter = line.split_whitespace();
            (
                $(iter.next().unwrap().parse::<$t>().unwrap(),)*
            )
        }
    };
    ($t:ty; $n:expr) => {
        (0..$n).map(|_|
            get!($t)
        ).collect::<Vec<_>>()
    };
    ($($t:ty),*; $n:expr) => {
        (0..$n).map(|_|
            get!($($t),*)
        ).collect::<Vec<_>>()
    };
    ($t:ty ;;) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.split_whitespace()
                .map(|t| t.parse::<$t>().unwrap())
                .collect::<Vec<_>>()
        }
    };
    ($t:ty ;; $n:expr) => {
        (0..$n).map(|_| get!($t ;;)).collect::<Vec<_>>()
    };
}

fn main() {
    let mut s = get!(String);
    while !s.is_empty() {
        let len = s.len();
        if s.ends_with("dream") {
            s = s[..len-5].to_string();
        } else if s.ends_with("dreamer") {
            s = s[..len-7].to_string();
        } else if s.ends_with("erase") {
            s = s[..len-5].to_string();
        } else if s.ends_with("eraser") {
            s = s[..len-6].to_string();
        } else {
            break;
        }
    }
    let r = if s.is_empty() {
        "YES"
    } else {
        "NO"
    };
    println!("{}", r);
}