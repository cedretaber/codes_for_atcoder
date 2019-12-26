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
    let (_n, _t) = get!(usize, usize);
    let aa = get!(String).split_whitespace().map(|n| n.parse::<usize>().unwrap()).collect::<Vec<_>>();

    let mut max_a = 0;
    let mut max_d = 0;
    let mut cnt = 0;
    for a in aa.into_iter().rev() {
        if max_a > a {
            let d = max_a - a;
            if d > max_d {
                max_d = d;
                cnt = 1;
            } else if d == max_d {
                cnt += 1;
            }
        } else {
            max_a = a;
        }
    }
    println!("{}", cnt);
}