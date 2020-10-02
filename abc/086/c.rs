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
    let mut x = 0;
    let mut y = 0;
    let mut t = 0;
    for _ in 0..n {
        let (t2, x2, y2) = get!(i32, i32, i32);
        let d = (x - x2).abs() + (y - y2).abs();
        if (t2 - t) < d || (t2 - t)%2 != d%2 {
            println!("No");
            return;
        }
        x = x2;
        y = y2;
        t = t2;
    }
    println!("Yes");
}