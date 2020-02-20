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
    let mut aa = Vec::new();
    let mut bb = Vec::new();
    for _ in 0..n {
        aa.push(get!(String).chars().into_iter().collect::<Vec<_>>());
    }
    for _ in 0..m {
        bb.push(get!(String).chars().into_iter().collect::<Vec<_>>());
    }

    for y in 0..n-m+1 {
        for x in 0..n-m+1 {
            let mut ok = true;
            for i in 0..m {
                for j in 0..m {
                    if !ok { break; }
                    if aa[y+i][x+j] != bb[i][j] { ok = false; }
                }
            }
            if ok {
                println!("Yes");
                return;
            }
        }
    }
    println!("No");
}