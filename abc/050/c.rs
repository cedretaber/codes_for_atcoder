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

fn pow_mod(mut n: usize, mut t: usize, p: usize) -> usize {
    let mut r = 1;
    while t > 0 {
        if t%2 == 1 {
            r = (r * n) % p;
        }
        n = n * n % p;
        t /= 2;
    }
    return r;
}

fn main() {
    let n = get!(usize);
    let mut aa = get!(String).split_whitespace().map(|a| a.parse::<i32>().unwrap()).collect::<Vec<_>>();
    aa.sort();
    let mut x = 0;
    let mut i = 0;
    if n%2 == 1 {
        if aa[i] != 0 {
            println!("{}", 0);
            return;
        }
        i = 1;
    } else {
        x = -1;
    }
    while i < n {
        x += 2;
        if aa[i] != x || aa[i+1] != x {
            println!("{}", 0);
            return;
        }
        i += 2;
    }

    println!("{}", pow_mod(2usize, n/2, 10usize.pow(9) + 7usize));
}