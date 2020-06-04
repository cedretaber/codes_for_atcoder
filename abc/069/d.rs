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
    let _n = get!(usize);

    let mut mm = vec![vec![0; w]; h];
    let mut i = 0;
    let mut j = 0;
    let mut d = 0;
    let mut c = 0;
    for a in get!(String).split_whitespace().map(|i| i.parse::<i32>().unwrap()) {
        c += 1;
        for _ in 0..a {
            mm[i][j] = c;
            match (d, j) {
                (0, _) if j+1 == w => { i += 1; d = 1; },
                (0, _) => j += 1,
                (_, _) if j == 0 => { i += 1; d = 0; },
                _ => j -= 1,
            }
        }
    }
    for line in mm.iter() {
        println!("{}", line.iter().map(ToString::to_string).collect::<Vec<_>>().join(" "));
    }
}