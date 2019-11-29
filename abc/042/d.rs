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
    const P: i64 = 1000000007;
    const L: usize = 200010;

    let mut f: Vec<i64> = vec![0; L];
    let mut rf: Vec<i64> = vec![0; L];

    f[0] = 1;
    f[1] = 1;
    for i in 2..L {
        f[i] = (f[i-1] * (i) as i64) % P;
    }

    rf[L-1] = 1;
    let mut x = f[L-1];
    let mut k = P-2;
    while k != 0 {
        if k%2 == 1 {
            rf[L-1] = (rf[L-1] * x) % P;
        }
        x = x.pow(2) % P;
        k /= 2;
    }

    for i in (0..L-1).rev() {
        rf[i] = (rf[i+1] * (i+1) as i64) % P;
    }

    let (h, w, a, b) = get!(i64, i64, i64, i64);

    let free_h = h - a;
    let free_w = w - b;
    let mut r: i64 = 0;
    for y in 1..free_h+1 {
        let i = ((f[(b+y-2) as usize] * rf[(b-1) as usize]) % P * rf[(y-1) as usize]) % P;
        let j = ((f[(free_w-1 + (h-y)) as usize] * rf[(free_w-1) as usize]) % P * rf[(h-y) as usize]) % P;
        r = (r + i*j) % P;
    }
    println!("{}", r);
}