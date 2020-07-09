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

fn main() {
    let (a, b, c, d, e, f) = get!(i32, i32, i32, i32, i32, i32);

    let mut rs = 0;
    let mut rw = a;
    for x in 0..31 {
        for y in 0..31 {
            let tw = x*a + y*b;
            for z in 0..tw*e/c+1 {
                if tw*100 + z*c > f { continue; }
                let w = cmp::min((tw*e-z*c)/d, (f-tw*100-z*c)/d);
                let ts = c*z + d*w;
                if ts * (rs+rw) > rs * (tw+ts) {
                    rs = ts;
                    rw = tw;
                }
            }
        }
    }
    println!("{} {}", rw * 100 + rs, rs);
}