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
    let k = get!(i64);

    let mut nn = Vec::new();
    for i in 0..50_i64 {
        nn.push(i);
    }
    let b = k/50;
    for i in 0..(50 as usize) {
        let d = if k%50 > (i as i64) { b + 1 } else { b };
        nn[i] += d * 50;
        for j in 0..(50 as usize) {
            if i != j {
                nn[j] -= d;
            }
        }
    }
    println!("50\n{}", nn.into_iter().map(|i| i.to_string()).collect::<Vec<_>>().join(" "));
}