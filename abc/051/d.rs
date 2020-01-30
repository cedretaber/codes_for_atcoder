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
    ($t:ty ;;) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.split_whitespace()
                .map(|t| t.parse::<$t>().unwrap())
                .collect::<Vec<_>>()
        }
    };
    ($t:ty ;; $n:expr) => {
        (0..$n).map(|_| get!($t ;;)).collect::<Vec<_>>()
    };
}

fn main() {
    let (n, m) = get!(usize, usize);
    let mut gr = vec![vec![std::usize::MAX / 3; n]; n];
    let mut ps = Vec::new();
    for _ in 0..m {
        let (a, b, c) = get!(usize, usize, usize);
        gr[a-1][b-1] = c;
        gr[b-1][a-1] = c;
        ps.push((a-1, b-1, c));
    }
    for k in 0..n {
        for i in 0..n {
            for j in 0..n {
                if gr[i][j] > gr[i][k] + gr[j][k] {
                    gr[i][j] = gr[i][k] + gr[j][k];
                }
            }
        }
    }
    let mut cnt = 0;
    for (a, b, c) in ps {
        if c > gr[a][b] { cnt += 1; }
    }
    println!("{}", cnt);
}