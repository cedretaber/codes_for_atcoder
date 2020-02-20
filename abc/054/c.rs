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


fn solve(i: usize, s: usize, n: usize, g: &Vec<Vec<usize>>) -> i64 {
    if s == (1<<n)-1 { return 1; }
    let mut r = 0;
    for &j in g[i].iter() {
        if (s & (1<<j)) != 0 { continue; }
        r += solve(j, s | (1<<j), n, g);
    }
    return r;
}

fn main() {
    let (n, m) = get!(usize, usize);
    let mut g = vec![Vec::new(); n];
    for _ in 0..m {
        let (a, b) = get!(usize, usize);
        g[a-1].push(b-1);
        g[b-1].push(a-1);
    }
    let r = solve(0, 1, n, &g);
    println!("{}", r);
}