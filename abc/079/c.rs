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
    let abcd = get!(String).chars().map(|c| c.to_string().parse::<i32>().unwrap()).collect::<Vec<_>>();
    let a = abcd[0];
    let b = abcd[1];
    let c = abcd[2];
    let d = abcd[3];

    for &o1 in ["+", "-"].into_iter() {
        for &o2 in ["+", "-"].into_iter() {
            for &o3 in ["+", "-"].into_iter() {
                let mut s = a;
                if o1 == "+" {
                    s += b;
                } else {
                    s -= b;
                }
                if o2 == "+" {
                    s += c;
                } else {
                    s -= c;
                }
                if o3 == "+" {
                    s += d;
                } else {
                    s -= d;
                }
                if s == 7 {
                    println!("{}{}{}{}{}{}{}=7", a, o1, b, o2, c, o3, d);
                    return;
                }
            }
        }
    }
}