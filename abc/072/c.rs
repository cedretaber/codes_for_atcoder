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
    let _n = get!(usize);
    let mut aa = vec![0; 100002];
    for a in get!(String).split_whitespace() {
        if let Ok(n) = a.parse::<usize>() {
            if n > 0 { aa[n-1] += 1; }
            aa[n] += 1;
            aa[n+1] += 1;
        }
    }
    println!("{}", aa.into_iter().fold(0, std::cmp::max));
}