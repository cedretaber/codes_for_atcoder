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
    let (n, m) = get!(usize, usize);
    let mut g = vec![Vec::new(); n];
    for _ in 0..m {
        let (a, b) = get!(usize, usize);
        g[a-1].push(b-1);
        g[b-1].push(a-1);
    }

    let mut memo = vec![false; n];
    memo[0] = true;
    let mut q = Vec::new();
    for &i in g[0].iter() {
        memo[i] = true;
        q.push(i);
    }
    for i in q.into_iter() {
        for &j in g[i].iter() {
            memo[j] = true;
        }
    }
    println!("{}", if memo[n-1] {
        "POSSIBLE"
    } else {
        "IMPOSSIBLE"
    });
}