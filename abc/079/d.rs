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
    let (h, _) = get!(usize, usize);
    let mut cs = Vec::new();
    for _ in 0..10 {
        cs.push(get!(String).split_whitespace().map(|c| c.parse::<i64>().unwrap()).collect::<Vec<_>>());
    }

    for k in 0..10 {
        for i in 0..10 {
            for j in 0..10 {
                if cs[i][j] > cs[i][k] + cs[k][j] {
                    cs[i][j] = cs[i][k] + cs[k][j];
                }
            }
        }
    }

    let mut r = 0;
    for _ in 0..h {
        for a in get!(String).split_whitespace() {
            if let Ok(i) = a.parse::<usize>() {
                r += cs[i][1];
            }
        }
    }
    println!("{}", r);
}