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
    let aa = get!(String).split_whitespace().map(|a| a.parse::<i32>().unwrap()).collect::<Vec<_>>();

    let mut max_i = 0;
    let mut max_a = 0;
    for (i, a) in aa.iter().enumerate() {
        if a.abs() > max_a {
            max_i = i;
            max_a = a.abs();
        }
    }

    let mut rs = Vec::new();
    for i in 0..n {
        if i != max_i {
            rs.push((max_i+1, i+1));
        }
    }

    if aa[max_i] < 0 {
        for i in (1..n).rev() {
            rs.push((i+1, i));
        }
    } else {
        for i in 0..n-1 {
            rs.push((i+1, i+2));
        }
    }

    println!("{}", rs.len());
    for (x, y) in rs {
        println!("{} {}", x, y);
    }
}