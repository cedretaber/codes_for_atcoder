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
    let mut ps = vec![true; 100_001];
    ps[0] = false;
    ps[1] = false;
    for i in 2..100_001 {
        if ps[i] {
            let mut j = i*2;
            while j <= 100_000 {
                ps[j] = false;
                j += i;
            }
        }
    }
    let mut ns = vec![0; 100_001];
    for i in 0..100_001 {
        if i != 0 { ns[i] += ns[i-1]; }
        if i%2 == 1 && ps[i] && ps[(i+1)/2] { ns[i] += 1; }
    }

    let q = get!(usize);
    for _ in 0..q {
        let (l, r) = get!(usize, usize);
        println!("{}", ns[r] - ns[l-1]);
    }
}