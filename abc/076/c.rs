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
    let mut s = get!(String).chars().collect::<Vec<_>>();
    let s_len = s.len();
    let t = get!(String).chars().collect::<Vec<_>>();
    let t_len = t.len();

    for i in (0..s_len-t_len+1).rev() {
        let mut ok = true;
        for j in 0..t_len {
            if s[i+j] != '?' && s[i+j] != t[j] {
                ok = false;
                break;
            }
        }
        if ok {
            for j in 0..t_len {
                s[i+j] = t[j];
            }
            for k in 0..s_len {
                if s[k] == '?' {
                    s[k] = 'a';
                }
            }
            println!("{}", s.into_iter().collect::<String>());
            return;
        }
    }
    println!("UNRESTORABLE");
}