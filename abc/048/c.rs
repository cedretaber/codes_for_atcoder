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
    let (n, x) = get!(usize, usize);
    let mut a = get!(String).split_whitespace().map(|t| t.parse::<usize>().unwrap()).collect::<Vec<_>>();

    let mut r = 0;
    if a[0] + a[1] > x {
        let d = (a[0] + a[1]) - x;
        r += d;
        if d > a[1] {
            a[1] = 0;
        } else {
            a[1] -= d;
        }
    }
    if a[0] + a[1] > x {
        a[0] = x;
    }
    for i in 1..n {
        if a[i-1] + a[i] > x {
            let d = (a[i-1] + a[i]) - x;
            a[i] -= d;
            r += d;
        }
    }
    println!("{}", r);
}