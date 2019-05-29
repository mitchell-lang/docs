(* Calculate distance of two points. *)
fun distance ((x1, y1), (x2, y2)) : real=
    (x1 - x2) * (x1 - x2) +
    (y1 - y2) * (y1 - y2)

(* Generate random centroids in given range. *)
fun centroidGen n (rangeX, rangeY) =
    let
        fun aux i =
            if i = n then [] else
            let
                val x = Mlrandom.uniformReal rangeX
                val y = Mlrandom.uniformReal rangeY
            in
                (x, y) :: (aux (i + 1))
            end
    in
        aux 0
    end

(* For a sample point in original data, calculate which centroid is closest. *)
fun whichCentroid centroids point =
    let
        val group =
            ExtendedList.foldli
                ((fn (r, i, centroid) => (* For each centriod: *)
                    let
                        val d = distance (centroid, point) (* Calculate the distance between point and one centriod. *)
                    in
                        case r of
                            NONE => SOME (i, d) (* If there is no centriod in history, record current one. *)
                          | SOME (i', d') =>
                            if d < d' (* Else, record the smaller one. *)
                            then
                                SOME (i, d)
                            else
                                r
                    end
                 ), NONE, centroids)
    in
        case group of
            NONE => raise Fail "No centroid."
          | SOME (group, _) => group
    end

(* Calculate new ith new centroid. *)
fun calCentroid centroids data ith =
    let
        val (sumX, sumY, num) = (* Calculate the sum of coordinate values and total number of points. *)
            List.foldl
                (fn ((x, y), (sumX, sumY, num)) => (* For each point in the data: *)
                            let
                                val centroidIth = whichCentroid centroids (x, y) (* Calculate which centriod is closest. *)
                            in
                                if centroidIth = ith (* If that centriod is the one we calculate currently... *)
                                then
                                    (sumX + x, sumY + y, num + 1)
                                else (* Else, do nothing.*)
                                    (sumX, sumY, num)
                            end) (0.0, 0.0, 0) data
    in
        (sumX/(Real.fromInt num), sumY/(Real.fromInt num)) (* New centroid is the average of all points. *)
    end

(* Training loop. *)
fun kmeansLoop centroids data n =
    if n = 0 then centroids else
    let
        val centroids =
            ExtendedList.mapi (* For each centroid, update it to a new one. *)
                ((fn (i, _) => calCentroid centroids data i),
                 centroids)
    in
        kmeansLoop centroids data (n - 1)
    end;

let
    val data = fromFile "data.txt" (* Read data. The data is a list of points(pair of real number). *)
    (*
    Data Format: data.txt:
    200 ----------> how many points
    99.3556817478 102.316592324 ----------> a point
    101.866292917 98.475273676
    ...
    *)
    val centroids = centroidGen 2 ((0.00, 100.00), (0.00, 100.00)) (* Generate two initial centroids randomly in range [0, 100] * [0, 100]. *)
    val centroids = kmeansLoop centroids data 3 (* Train 3 times. *)
    val _ = print ("Centroids:\n" ^ (centroidsToString centroids)) (* Print the result. *)
in
    ()
end;
