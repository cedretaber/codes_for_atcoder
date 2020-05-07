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
    let aa = get!(usize; n).into_iter().map(|i| i-1).collect::<Vec<_>>();
    let mut bb = vec![false; n];
    bb[0] = true;
    let mut i = 0;
    let mut c = 0;
    while bb[1] == false {
        i = aa[i];
        if bb[i] {
            println!("-1");
            return;
        }
        bb[i] = true;
        c += 1;
    }
    println!("{}", c);
}