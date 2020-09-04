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
}

fn main() {
    let mut s = get!(String).chars().collect::<Vec<_>>();
    s.sort();
    let sp = s.into_iter().collect::<String>();
    let mut t = get!(String).chars().collect::<Vec<_>>();
    t.sort_by(|a, b| b.cmp(a));
    let tp = t.into_iter().collect::<String>();
    println!("{}", if sp < tp { "Yes" } else { "No" });
}