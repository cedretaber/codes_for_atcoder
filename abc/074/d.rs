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
    let mut m = Vec::new();
    for _ in 0..n {
        m.push(get!(String).split_whitespace().map(|i| i.parse::<i64>().unwrap()).collect::<Vec<_>>());
    }

    for k in 0..n {
        for i in 0..n {
            for j in 0..n {
                if m[i][j] > m[i][k] + m[k][j] {
                    println!("-1");
                    return;
                }
            }
        }
    }

    let mut r = 0;
    for i in 0..n {
        for j in 0..n {
            let mut f = true;
            for k in 0..n {
                if i != k && j != k && m[i][j] == m[i][k] + m[k][j] {
                    f = false;
                    break;
                }
            }
            if f { r += m[i][j]; }
        }
    }
    println!("{}", r/2);
}