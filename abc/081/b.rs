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

    let mut c = 0;
    loop {
        for a in aa.iter() {
            if a%2 == 1 {
                println!("{}", c);
                return;
            }
        }
        c += 1;
        let bb = aa.into_iter().map(|a| a/2).collect();
        aa = bb;
    }
}