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
    let (h, w) = get!(usize, usize);
    let mut r = vec![vec!['#'; w+2]; h+2];
    let mut aa = Vec::new();
    for _ in 0..h {
        aa.push(get!(String).chars().collect::<Vec<_>>());
    }
    for i in 0..h {
        for j in 0..w {
            r[i+1][j+1] = aa[i][j];
        }
    }
    for a in r.into_iter() {
        println!("{}", a.into_iter().collect::<String>())
    }
}