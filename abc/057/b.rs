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
    let (n, m) = get!(usize, usize);
    let mut ss = Vec::new();
    for _ in 0..n {
        ss.push(get!(i64, i64));
    }
    let mut ps = Vec::new();
    for _ in 0..m {
        ps.push(get!(i64, i64));
    }

    for (a, b) in ss.into_iter() {
        let mut min_d = i64::max_value();
        let mut p = 0;
        for i in 0..m {
            let (c, d) = ps[i];
            let d = (a-c).abs() + (b-d).abs();
            if d < min_d {
                min_d = d;
                p = i;
            }
        }
        println!("{}", p+1);
    }
}