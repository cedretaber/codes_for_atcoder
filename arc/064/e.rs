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

use std::cmp::Ordering;

#[derive(PartialEq, Debug)]
struct Point {
    i: usize,
    c: f64
}

impl PartialOrd for Point {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        match self.c.partial_cmp(&other.c) {
            Some(Ordering::Less) => Some(Ordering::Greater),
            Some(Ordering::Greater) => Some(Ordering::Less),
            other => other
        }
    }
}

impl Eq for Point { }

impl Ord for Point {
    fn cmp(&self, other: &Self) -> Ordering {
        self.partial_cmp(&other).unwrap()
    }
}

use std::collections::BinaryHeap;
use std::f64;

fn main() {
    let (xs, ys, xt, yt) = get!(f64, f64, f64, f64);
    let n = get!(usize);
    let mut xyr = get!(f64, f64, f64; n);
    xyr.push((xs, ys, 0.0));
    xyr.push((xt, yt, 0.0));

    let mut mincs = vec![f64::INFINITY; n+2];
    mincs[n] = 0.0;
    let mut q = BinaryHeap::new();
    q.push(Point { i: n, c: 0.0 });

    let mut ds = vec![vec![0.0; n+2]; n+2];
    for i in 0..n+1 {
        for j in i+1..n+2 {
            let (x1, y1, r1) = xyr[i];
            let (x2, y2, r2) = xyr[j];
            let d = ((x1 - x2).powi(2) + (y1 - y2).powi(2)).sqrt();
            let d = if d < r1 + r2 { 0.0 } else { d - (r1 + r2) };
            ds[i][j] = d;
            ds[j][i] = d;
        }
    }

    while let Some(Point { i, c }) = q.pop() {
        if i == n+1 {
            println!("{:.10}", mincs[n+1]);
            return;
        }
        for j in 0..n+2 {
            if i == j { continue };
            let d = c + ds[i][j];
            if mincs[j] > d {
                mincs[j] = d;
                q.push(Point { i: j, c: d });
            }
        }
    }
}