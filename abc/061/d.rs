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

fn main()
{
    let (n, m) = get!(usize, usize);
    let mut es = Vec::new();
    for _ in 0..m {
        let (a, b, c) = get!(usize, usize, i64);
        es.push((a-1, b-1, c));
    }

    let mut ds = vec![i64::min_value()/3; n];
    ds[0] = 0;
    for _ in 0..n {
        for &(a, b, c) in es.iter() {
            if ds[b] < ds[a] + c {
                ds[b] = ds[a] + c;
            }
        }
    }
    let d = ds[n-1];
    for _ in 0..n {
        for &(a, b, c) in es.iter() {
            if ds[b] < ds[a] + c {
                ds[b] = ds[a] + c;
            }
        }
    }
    if d == ds[n-1] {
        println!("{}", d);
    } else {
        println!("inf");
    }
}