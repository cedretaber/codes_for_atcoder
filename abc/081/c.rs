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
    let (n, k) = get!(usize, i32);
    let mut aa = vec![0; n+1];
    for s in get!(String).split_whitespace() {
        let a = s.parse::<usize>().unwrap();
        aa[a] += 1;
    }
    aa.sort();
    let mut m = 0;
    for &a in aa.iter() {
        if a != 0 {
            m += 1;
        }
    }
    m -= k;
    let mut r = 0;
    for a in aa.into_iter() {
        if m <= 0 {
            println!("{}", r);
            return;
        }
        if a == 0 { continue; }
        m -= 1;
        r += a;
    }
}