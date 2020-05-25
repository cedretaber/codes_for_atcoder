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

enum Res {
    No,
    Mid(i32),
    Res(usize, usize),
}

fn divide(i: usize, p: usize, n: usize, c: i32, t: &Vec<Vec<usize>>) -> Res {
    if i == n {
        return Res::Mid(c);
    }
    for &j in t[i].iter() {
        if j != p {
            match divide(j, i, n, c+1, t) {
                Res::No => (),
                Res::Res(x, y) => return Res::Res(x, y),
                Res::Mid(d) if d/2 == c => return Res::Res(i, j),
                Res::Mid(d) => return Res::Mid(d)
            }
        }
    }
    Res::No
}

use std::ops::Add;

fn count(i: usize, p: usize, t: &Vec<Vec<usize>>) -> i32 {
    t[i].iter().map(|&j| if j == p { 0 } else { count(j, i, t) }).fold(1, Add::add)
}

fn main() {
    let n = get!(usize);
    let mut t = vec![Vec::new(); n];
    for _ in 1..n {
        let (a, b) = get!(usize, usize);
        t[a-1].push(b-1);
        t[b-1].push(a-1);
    }

    if let Res::Res(x, y) = divide(0, n, n-1, 0, &t) {
        if count(x, y, &t) > count(y, x, &t) {
            println!("Fennec");
        } else {
            println!("Snuke");
        }
    }
}