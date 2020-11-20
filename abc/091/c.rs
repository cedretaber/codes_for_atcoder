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
        ).collect::<Vec<_>>()å
    };
}

#[derive(Debug, PartialEq, Eq, PartialOrd, Ord)]
struct P {
    x: usize,
    y: usize,
}

#[derive(Debug, PartialEq, Eq, PartialOrd, Ord)]
struct Q {
    y: usize,
    x: usize,
}

fn main() {
    let n = get!(usize);
    let mut rr = Vec::new();
    let mut bb = Vec::new();
    for _ in 0..n {
        let (x, y) = get!(usize, usize);
        rr.push(Q { x: x, y: y });
    }
    rr.sort();
    for _ in 0..n {
        let (x, y) = get!(usize, usize);
        bb.push(P { x: x, y: y });
    }
    bb.sort();

    let mut memo = vec![false; n];
    let mut cnt = 0;
    for b in bb.into_iter() {
        for i in (0..n).rev() {
            if !memo[i] && rr[i].x < b.x && rr[i].y < b.y {
                cnt += 1;
                memo[i] = true;
                break;
            }
        }
    }
    println!("{}", cnt);
}