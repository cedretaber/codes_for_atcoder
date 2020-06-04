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
    let _n = get!(usize);
    let mut x = 0;
    let mut y = 0;
    let mut z = 0;
    for a in get!(String).split_whitespace().map(|i| i.parse::<i32>().unwrap()) {
        match a {
            _ if a%4 == 0 => x += 1,
            _ if a%2 == 0 => y += 1,
            _ => z += 1,
        }
    }
    if y > 0 {
        z += 1;
    }
    println!("{}", if x >= z-1 { "Yes" } else { "No" });
}