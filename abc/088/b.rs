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
    let _n = get!(usize);
    let mut aa = get!(String).split_whitespace().map(|a| a.parse::<i32>().unwrap()).collect::<Vec<_>>();
    aa.sort();
    aa.reverse();
    let mut a = 0;
    let mut b = 0;
    for (i, &x) in aa.iter().enumerate() {
        if i%2 == 0 {
            a += x;
        } else {
            b += x;
        }
    }
    println!("{}", a - b);
}