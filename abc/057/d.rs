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

use std::collections::HashMap;

fn main() {
    let (n, a, b) = get!(usize, usize, usize);
    let mut vs = get!(String).split_whitespace().map(|v| v.parse().unwrap()).collect::<Vec<usize>>();
    vs.sort();
    vs.reverse();

    let mut map = HashMap::new();
    for i in 0..n {
        let x = map.entry(vs[i]).or_insert(0 as usize);
        *x += 1;
    }

    let mut tri: Vec<Vec<usize>> = Vec::new();
    tri.push(vec![1]);
    tri.push(vec![1, 1]);
    for i in 2..n+1 {
        let mut line = vec![1];
        for j in 0..i-1 {
            line.push(tri[i-1][j] + tri[i-1][j+1]);
        }
        line.push(1);
        tri.push(line);
    }

    if vs[0] == vs[a-1] {
        let mut c = 0;
        for x in a..b+1 {
            if x <= map.get(&vs[0]).unwrap()+0 {
                c += tri[map.get(&vs[0]).unwrap()+0][x];
            }
        }
        println!("{}", vs[0]);
        println!("{}", c);
    } else {
        let mut c = 0;
        let mut s: f64 = 0.0;
        for i in 0..a {
            if vs[i] == vs[a-1] { c += 1; }
            s += vs[i] as f64;
        }
        println!("{:.10}", s / (a as f64));
        println!("{}", tri[map.get(&vs[a-1]).unwrap()+0][c]);
    }
}