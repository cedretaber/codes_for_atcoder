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
    let (a, b) = get!(usize, usize);
    let s = get!(String).chars().collect::<Vec<_>>();
    if s.len() != a+b+1 || s[a] != '-' {
        println!("No");
        return;
    }
    for i in 0..a+b+1 {
        if i != a && (s[i] < '0' || s[i] > '9') {
            println!("No");
            return;
        }
    }
    println!("Yes");
}