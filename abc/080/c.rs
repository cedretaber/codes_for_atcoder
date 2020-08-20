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

use std::cmp;

fn solve(i: usize, n: usize, mut bs: &mut Vec<bool>, fs: &Vec<Vec<bool>>, ps: &Vec<Vec<i32>>) -> i32 {
    if i == 10 {
        if bs.iter().all(|b|!b) {
            std::i32::MIN
        } else {
            (0..n).map(|i| ps[i][bs.iter().zip(fs[i].iter()).filter(|&(&a, &b)| a && b).count() as usize]).sum()
        }
    } else {
        bs[i] = false;
        let r1 = solve(i+1, n, bs, fs, ps);
        bs[i] = true;
        let r2 = solve(i+1, n, bs, fs, ps);
        cmp::max(r1, r2)
    }
}

fn main() {
    let n = get!(usize);
    let fs = (0..n).map(|_| get!(String).split_whitespace().map(|f| f == "1").collect::<Vec<_>>()).collect::<Vec<_>>();
    let ps = (0..n).map(|_| get!(String).split_whitespace().map(|p| p.parse::<i32>().unwrap()).collect::<Vec<_>>()).collect::<Vec<_>>();
    println!("{}", solve(0, n, &mut vec![false; 10], &fs, &ps));
}