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

use std::collections::HashSet;

fn main() {
    let s = get!(String).chars().collect::<Vec<_>>();
    let (mut x, y) = get!(i32, i32);

    let mut n = 0;
    let mut d: i32 = 0;
    let mut xx = Vec::new();
    let mut yy = Vec::new();
    for c in s {
        if c == 'F' {
            d += 1;
        } else {
            if n == 0 {
                x -= d;
            } else if d != 0 {
                if n%2 == 0 {
                    xx.push(d);
                } else {
                    yy.push(d);
                }
            }
            d = 0;
            n += 1;
        }
    }
    if n == 0 {
        x -= d;
    } else if d != 0 {
        if n%2 == 0 {
            xx.push(d);
        } else {
            yy.push(d);
        }
    }

    let mut xs = HashSet::new();
    xs.insert(0);
    for x in xx.into_iter() {
        let mut xxs = HashSet::new();
        for &xx in &xs {
            xxs.insert(xx + x);
            xxs.insert(xx - x);
        }
        xs.clear();
        for &xx in &xxs {
            xs.insert(xx);
        }
    }

    if !xs.contains(&x) {
        println!("No");
        return;
    }

    let mut ys = HashSet::new();
    ys.insert(0);
    for y in yy.into_iter() {
        let mut yys = HashSet::new();
        for &yy in &ys {
            yys.insert(yy + y);
            yys.insert(yy - y);
        }
        ys.clear();
        for &yy in &yys {
            ys.insert(yy);
        }
    }

    println!("{}", if ys.contains(&y) { "Yes" } else { "No" });
}