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

fn solve(i: usize, c: usize, v: usize, n: usize, a: usize, xs: &Vec<usize>, dp: &mut Vec<Vec<Vec<i64>>>) -> i64 {
    if i == n {
        if c == 0 { 
            return if a == 0 { 1 } else { 0 };
        }
        return if v % c == 0 && v / c == a { 1 } else { 0 };
    }
    if dp[i][c][v] == -1 {
        dp[i][c][v] = solve(i+1, c, v, n, a, xs, dp) + solve(i+1, c+1, v + xs[i], n, a, xs, dp);
    }
    return dp[i][c][v];
}

fn main() {
    let (n, a) = get!(usize, usize);
    let xs = get!(String).split_whitespace().map(|t| t.parse::<usize>().unwrap()).collect::<Vec<_>>();
    let mut dp: Vec<Vec<Vec<i64>>> = vec![vec![vec![-1; 50*n+1]; n+1]; n+1];
    println!("{}", solve(0, 0, 0, n, a, &xs, &mut dp));
}