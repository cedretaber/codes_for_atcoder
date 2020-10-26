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
    let mut pp = vec![0_i64; 5];
    for _ in 0..n {
        let s = get!(String);
        match s.chars().next().unwrap() {
            'M' => pp[0] += 1,
            'A' => pp[1] += 1,
            'R' => pp[2] += 1,
            'C' => pp[3] += 1,
            'H' => pp[4] += 1,
            _ => (),
        }
    }
    let mut p = 0;
    for i in 0..3 {
        for j in i+1..4 {
            for k in j+1..5 {
                p += pp[i] * pp[j] * pp[k];
            }
        }
    }
    println!("{}", p);
}