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
    const P: i64 = 1000000007;
    const L: usize = 100010;

    let mut f: Vec<i64> = vec![0; L];

    f[0] = 1;
    f[1] = 1;
    for i in 2..L {
        f[i] = (f[i-1] * (i) as i64) % P;
    }

    let (n, m) = get!(i64, i64);
    if (n-m).abs() > 1 {
        println!(0);
        return;
    }
    if n == m {
        println!("{}", f[n as usize] * f[m as usize] % P * 2 % P);
    } else {
        println!("{}", f[n as usize] * f[m as usize] % P);
    }
}