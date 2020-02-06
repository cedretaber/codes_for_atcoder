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

const P: usize = 1000000007;

fn prime_division(n: usize, a: &mut Vec<usize>) {
    let mut x = n;
    for i in 2..n+1 {
        while x%i == 0 {
            a[i] += 1;
            x /= i;
        }
    }
}

fn main() {
    let n = get!(usize);
    let mut a = vec![0; 1000];
    for i in 2..n+1 {
        prime_division(i, &mut a)
    }
    let mut r: usize = 1;
    for x in a {
        if x > 0 {
            r = (r * (x+1)) % P;
        }
    }
    println!("{}", r);
}