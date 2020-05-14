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
    let aa = get!(String).split_whitespace().map(|i| i.parse::<i32>().unwrap()).enumerate().collect::<Vec<_>>();
    let mut bb = Vec::new();
    let mut cc = Vec::new();
    for (i, a) in aa.into_iter() {
        if i%2 == 1 {
            bb.push(a);
        } else {
            cc.push(a);
        }
    }
    let res = if n%2 == 0 {
        bb.reverse();
        [bb, cc]
    } else {
        cc.reverse();
        [cc, bb] 
    };
    println!("{}", res.concat().into_iter().map(ToString::to_string).collect::<Vec<_>>().join(" "));
}