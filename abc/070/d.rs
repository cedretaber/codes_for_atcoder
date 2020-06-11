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

#[derive(Debug, Copy, Clone)]
struct P {
    to: usize,
    c: u64,
}

fn walk(i: usize, p: usize, l: u64, t: &Vec<Vec<P>>, mut ll: &mut Vec<u64>) {
    ll[i] = l;
    for j in t[i].iter() {
        if j.to != p {
            walk(j.to, i, l+j.c, t, ll);
        }
    }
}

fn main() {
    let n = get!(usize);
    let mut t = vec![Vec::new(); n];
    for _ in 1..n {
        let (a, b, c) = get!(usize, usize, u64);
        t[a-1].push(P { to: b-1, c: c });
        t[b-1].push(P { to: a-1, c: c });
    }
    let (q, k) = get!(usize, usize);
    let mut ll = vec![0; n];
    walk(k-1, n, 0, &t, &mut ll);
    for _ in 0..q {
        let (x, y) = get!(usize, usize);
        println!("{}", ll[x-1] + ll[y-1]);
    }
}