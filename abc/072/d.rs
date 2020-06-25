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
    let mut pp = get!(String).split_whitespace().map(|p| p.parse::<usize>().unwrap()).collect::<Vec<_>>();
    let mut r = 0;
    for i in 0..n-1 {
        let p = i+1;
        if pp[i] == p {
            pp.swap(i, i+1);
            r += 1;
        }
    }
    if pp[n-1] == n { r += 1; }
    println!("{}", r);
}