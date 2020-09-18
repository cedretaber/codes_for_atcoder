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
    let n = get!(usize);
    let mut cs = Vec::new();
    let mut ss = Vec::new();
    let mut fs = Vec::new();
    for _ in 1..n {
        let (c, s, f) = get!(i64, i64, i64);
        cs.push(c);
        ss.push(s);
        fs.push(f);
    }
    for x in 0..n-1 {
        let mut t = 0;
        for i in x..n-1 {
            if t < ss[i] { t = ss[i]; }
            if t % fs[i] != 0 { t += fs[i] - t % fs[i]; }
            t += cs[i];
        }
        println!("{}", t);
    }
    println!("0");
}