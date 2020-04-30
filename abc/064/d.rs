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
    let s = get!(String).chars().collect::<Vec<_>>();

    let mut h = 0;
    let mut t = 0;
    let mut x = 0;
    for i in 0..n {
        if s[i] == '(' {
            x += 1;
        } else if x > 0 {
            x -= 1;
        } else {
            h += 1;
        }
    }
    x = 0;
    for i in (0..n).rev() {
        if s[i] == ')' {
            x += 1;
        } else if x > 0 {
            x -= 1;
        } else {
            t += 1;
        }
    }


    let mut r = Vec::new();
    for _ in 0..h { r.push('('); }
    for c in s.into_iter() { r.push(c); }
    for _ in 0..t { r.push(')'); }
    println!("{}", r.into_iter().collect::<String>());
}