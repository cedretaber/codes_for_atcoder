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
    let (c11, c12, c13) = get!(i32, i32, i32);
    let (c21, c22, c23) = get!(i32, i32, i32);
    let (c31, c32, c33) = get!(i32, i32, i32);

    for a1 in 0..101 {
        for a2 in 0..101 {
            for a3 in 0..101 {
                if
                    c11 - a1 == c12 - a2 && c12 - a2 == c13 - a3 &&
                    c21 - a1 == c22 - a2 && c22 - a2 == c23 - a3 &&
                    c31 - a1 == c32 - a2 && c32 - a2 == c33 - a3 {
                        println!("Yes");
                        return;
                    }
            }
        }
    }
    println!("No");
}