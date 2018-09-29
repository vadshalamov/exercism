pub fn raindrops(n: u32) -> String {
    match n {
        n if (n % 3 == 0) && (n % 5 == 0) && (n % 7 == 0) => String::from("PlingPlangPlong"),
        n if (n % 3 == 0) && (n % 7 == 0) => String::from("PlingPlong"),
        n if (n % 3 == 0) && (n % 5 == 0) => String::from("PlingPlang"),
        n if (n % 5 == 0) && (n % 7 == 0) => String::from("PlangPlong"),
        n if (n % 3 == 0) => String::from("Pling"),
        n if (n % 5 == 0) => String::from("Plang"),
        n if (n % 7 == 0) => String::from("Plong"),
        n => n.to_string(),
    }
}
