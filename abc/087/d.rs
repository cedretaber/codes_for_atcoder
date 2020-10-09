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

fn solve(i: usize, d: i64, t: &Vec<Vec<(usize, i64)>>, ps: &mut Vec<Option<i64>>) -> bool {
    if let Some(e) = ps[i] {
        d == e
    } else {
        ps[i] = Some(d);
        t[i].iter().all(|&(j, dd)| solve(j, d + dd, t, ps))
    }
}

fn main() {
    let (n, m) = get!(usize, usize);
    let mut t = vec![Vec::new(); n];
    for _ in 0..m {
        let (l, r, d) = get!(usize, usize, i64);
        t[l-1].push((r-1, d));
        t[r-1].push((l-1, -d));
    }

    let mut ps = vec![None; n];
    println!("{}", if (0..n).all(|i| ps[i].is_some() || solve(i, 0, &t, &mut ps)) { "Yes" } else { "No" });
}