#' @title Creates a new job
#' @description \code{job_create} creates a new CrowdFlower Job.
#' @param title A character string containing the title for a new job.
#' @param instructions A character string containing instructions for a new job.
#' @param cml Layout for new job.
#' @param verbose A logical indicating whether to print additional information about the request.
#' @param ... Additional arguments passed to \code{\link{cf_query}}.
#' @return An integer specify the job ID.
#' @references \href{https://success.crowdflower.com/hc/en-us/articles/202703425-CrowdFlower-API-Requests-Guide}{Crowdflower API documentation}
#' @examples
#' \dontrun{
#' # create new job
#' f1 <- system.file("templates/instructions1.html", package = "crowdflower")
#' f2 <- system.file("templates/cml1.xml", package = "crowdflower")
#' j <- job_create(title = "Job Title", 
#'                 instructions = readChar(f1, nchars = 1e8L),
#'                 cml = readChar(f2, nchars = 1e8L))
#'
#' # add data
#' d <- data.frame(variable = 1:3)
#' job_add_data(id = j, data = d)
#'
#' # launch job
#' job_launch(id = j)
#' 
#' # get results
#' results_get(id = j)
#' 
#' # delete job
#' job_delete(j)
#' }
#' @seealso \code{\link{job_update}}, \code{\link{job_add_data}}, \code{\link{job_launch}}, \code{\link{job_status}}, \code{\link{job_delete}}, \code{\link{report_get}}
#' @keywords jobs
#' @export
job_create <- function(title = NULL, instructions = NULL, cml = NULL, verbose = TRUE, ...){

    body <- list()
    if (!is.null(title)) {
        body['job[title]'] <- title
    }
    if (!is.null(instructions)) {
        body['job[instructions]'] <- instructions
    }
    if (!is.null(cml)) {
        body['job[cml]'] <- cml
    }

    # API request to create job
    newjob <- cf_query("jobs.json", type="POST", body=body, ...)
    if (verbose) {
        message("Job successfully created with ID = ", newjob$id)
    }
    return(newjob$id)
}
