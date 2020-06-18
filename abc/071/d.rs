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

const P: u64 = 1000000007;

fn main() {
    let n = get!(usize);
    let s1 = get!(String).chars().collect::<Vec<_>>();
    let s2 = get!(String).chars().collect::<Vec<_>>();

    let mut r;
    let mut i: usize;
    if s1[0] == s2[0] {
        r = 3;
        i = 1;
    } else {
        r = 6;
        i = 2;
    }
    while i < n {
        if s1[i] == s2[i] {
            if s1[i-1] == s2[i-1] {
                r *= 2;
                r %= P;
            }
            i += 1;
        } else {
            if s1[i-1] == s2[i-1] {
                r *= 2;
                r %= P;
            } else {
                r *= 3;
                r %= P;
            }
            i += 2;
        }
    }
    println!("{}", r);
}